import akshare as ak
import math
import pandas as pd
import thread

# fetch all existing stock's current snapshot
stock_zh_a_spot_df = ak.stock_zh_a_spot()


global_result_dic = {}

def unit_selector(stock_zh_a_spot_df):
    for index, row in stock_zh_a_spot_df.iterrows():
        # sh600000, sz......
        stock_code = row['代码'] 
        print('stock_code: ' + stock_code)
    
        short_stock_code = stock_code[2:]
        print('short_stock_code: ' + short_stock_code)
        stock_zh_a_hist_df = ak.stock_zh_a_hist(symbol=short_stock_code, period="daily", start_date="20170301", end_date='21211107', adjust="qfq")
        cur_price = stock_zh_a_hist_df[['收盘']].iat[-1,0]
        print('cur_price: ' + str(cur_price) + '(' + str(type(cur_price)) + ')')
    
        stock_financial_analysis_indicator_df = ak.stock_financial_analysis_indicator(stock=short_stock_code)
        cur_unassigned_benefit = stock_financial_analysis_indicator_df[['每股未分配利润(元)']].iat[0,0]
        cur_unassigned_benefit = float(cur_unassigned_benefit)
        print('cur_unassigned_benefit: ' + str(cur_unassigned_benefit) +'(' + str(type(cur_unassigned_benefit)) + ')')
    
        
        if cur_unassigned_benefit >= cur_price:
            global_result_dic[stock_code] = cur_unassigned_benefit
            #with open('stock_sel_result.dat', 'a') as file:
                #file.write(stock_code + " " + str(cur_price) + " " + str(cur_unassigned_benefit) + "\n")
    

stock_zh_a_spot_df
seg_num = 50
unit_selector_threads = list()

df_num = len(stock_zh_a_spot_df)
every_epoch_num = math.floor((df_num/seg_num))
for index in range(seg_num):
    if index < seg_num-1:
        df_seg = stock_zh_a_spot_df[every_epoch_num * index: every_epoch_num * (index + 1)]
    else:
        df_seg = stock_zh_a_spot_df[every_epoch_num * index:]
    thread.start_new_thread(unit_selector, ("Thread-1", 2, ) )
    unit_selector_thread = threading.Thread(target=unit_selector, args=(df_seg,))
    unit_selector_threads.append(unit_selector_thread)
    unit_selector_thread.start()

for index, thread in enumerate(unit_selector_threads):
    print("Main    : before joining thread %d.", index)
    thread.join()
    print("Main    : thread %d done", index)

print("All unit selectors finished")    
global_result_dic



