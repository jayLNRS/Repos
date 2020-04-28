# loadtesting
Load testing script and results

## Usage
```
$ AUTH_BASIC=xxx ./loadtest
```

## Results
```
$ grep 'Requests per second' 2020-03-30/*
2020-03-30/c10_n20000.txt:Requests per second:    7.51 [#/sec] (mean)
2020-03-30/c15_n30000.txt:Requests per second:    9.76 [#/sec] (mean)
2020-03-30/c20_n40000.txt:Requests per second:    10.20 [#/sec] (mean)
2020-03-30/c25_n50000.txt:Requests per second:    9.59 [#/sec] (mean)
2020-03-30/c30_n60000.txt:Requests per second:    10.95 [#/sec] (mean)
$ grep 'Requests per second' 2020-04-28/*
2020-04-28/c10_n20000.txt:Requests per second:    7.48 [#/sec] (mean)
2020-04-28/c15_n30000.txt:Requests per second:    8.50 [#/sec] (mean)
2020-04-28/c20_n40000.txt:Requests per second:    8.87 [#/sec] (mean)
2020-04-28/c25_n50000.txt:Requests per second:    9.10 [#/sec] (mean)
2020-04-28/c30_n60000.txt:Requests per second:    9.22 [#/sec] (mean)
```
