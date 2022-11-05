import akshare as ak
#import csv
import pandas as pd
from datetime import date 
from os import path 
import time 

# save and check stock metadata cache.
force_refresh = False
stock_metadata_cache_filepath = '/Users/hczhang/amazon_laptops/Personal/stock/stock_metadata_cache.csv'
if path.isfile(stock_metadata_cache_filepath) and not force_refresh:
    stock_zh_a_spot_df = pd.read_csv(stock_metadata_cache_filepath)
else:
    # fetch all existing stock's current snapshot and save cache
    stock_zh_a_spot_df = ak.stock_zh_a_spot()
    stock_zh_a_spot_df.to_csv(stock_metadata_cache_filepath, header=True) 


# check cache file 
stock_cache_filepath = '/Users/hczhang/amazon_laptops/Personal/stock/stock_cache.csv'
stock_cache_df = pd.read_csv(stock_cache_filepath)

index = 0
while index < len(stock_zh_a_spot_df):
    # sh600000, sz......
    row = stock_zh_a_spot_df.loc[index]
    stock_code = row['代码'] 
    print('stock_code: ' + stock_code)
    #if stock_code in stock_cache_df.stock_code:
    if stock_cache_df['stock_code'].str.contains(stock_code).any():
        print('Existed, skip: ' + stock_code)
        index+=1
        continue
    
    
    short_stock_code = stock_code[2:]
    print('short_stock_code: ' + short_stock_code)
    
    try:
        # stock history not needed, save some time.
        #stock_zh_a_hist_df = ak.stock_zh_a_hist(symbol=short_stock_code, period="daily", start_date="20170301", end_date='21211107', adjust="qfq")
        #cur_price = stock_zh_a_hist_df[['收盘']].iat[-1,0]
        cur_price = row['昨收']
        print('cur_price: ' + str(cur_price) + '(' + str(type(cur_price)) + ')')
        stock_financial_analysis_indicator_df = ak.stock_financial_analysis_indicator(stock=short_stock_code)
        cur_unassigned_benefit = stock_financial_analysis_indicator_df[['每股未分配利润(元)']].iat[0,0]
        cur_unassigned_benefit = float(cur_unassigned_benefit)
        print('cur_unassigned_benefit: ' + str(cur_unassigned_benefit) +'(' + str(type(cur_unassigned_benefit)) + ')')
        # Cache handler
        cur_date = date.today().strftime("%Y/%m/%d")
        cur_item_data = [{'stock_code': stock_code, 'cur_price': cur_price, 'cur_unassigned_benefit':cur_unassigned_benefit, 'date':cur_date}]
        cur_item_df = pd.DataFrame(cur_item_data)
        cur_item_df.to_csv(stock_cache_filepath, mode='a', header=False) 
        
        index+=1
        
        result_dic = {}
        if cur_unassigned_benefit >= cur_price:
            result_dic[stock_code] = cur_unassigned_benefit
            
    except:
        print('throttled, sleeping...')
        time.sleep(312)
        continue

    result_dic

    
    
    
    
    # throttling several seconds for several items    
    #if index % 4 == 0:
    #    print('group finished, sleeping...')
    #    time.sleep(165)

    
    
        #with open('stock_sel_result.dat', 'a') as file:
            #file.write(stock_code + " " + str(cur_price) + " " + str(cur_unassigned_benefit) + "\n")
    
    



