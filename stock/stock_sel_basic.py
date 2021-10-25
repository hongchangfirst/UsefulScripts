import akshare as ak

# fetch all existing stock's current snapshot
stock_zh_a_spot_df = ak.stock_zh_a_spot()

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
        with open('stock_sel_result.dat', 'a') as file:
            file.write(stock_code + " " + str(cur_price) + " " + str(cur_unassigned_benefit) + "\n")
    

