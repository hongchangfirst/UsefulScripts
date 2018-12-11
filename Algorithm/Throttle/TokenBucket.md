Associated to each clientId, assume a bucket of tokens, that has a capacity of 100 tokens and a continuous inflow of 100 tokens per second (or 1 token every 0.01s). 
Each request from a client takes a token from the bucket with that clientId. If that bucket is empty, the request should not be allowed.
If the bucket is full, then no more tokens are allocated.

Regarding to implementation, for each bucket, only the timestamp of the last request and the token count needs to be stored. 

TokenBucket {

  int timestamp;
  
  int tokenCount;
  
}

### Basic Logic:

Having a thread to add 1 token in the bucket per 1/100 second. If the tokenCount is larger than the max one, then do nothing. Having other threads to extract 1 token in the bucket per request. if the tokenCount is less than 1, then reject the request, otherwise pass the request.

### An efficient Solution:

1 When a new request comes, first add 0.01*(current_time-bucket.timestamp) tokens to the bucket, and update the timestamp on the bucket. 

2 If the bucket has more than or equal to 1 tokens, take a single token, and allow the request. If the tokenCount larger than the max tokens a bucket can have, then set tokenCount to the maximum number.

3 Else, reject the request.

