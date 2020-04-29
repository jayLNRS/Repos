# loadtesting
Load testing script, EC2 instance specs and results

## Usage
```
$ AUTH_BASIC=xxx ./loadtest
```

## Load Testing Results

### 2020-04-29

**Front-end: t3a.xlarge** (Burstable, AMD EPYC 4 vCPU, 16 GB RAM, 5 Gbps Network)  
**Back-end: t3a.2xlarge** (Burstable, AMD EPYC 8 vCPU, 32 GB RAM, 5 Gbps Network)  

```
$ grep 'Requests per second' 2020-04-29/*
2020-04-29/c05_n10000.txt:Requests per second:    3.93 [#/sec] (mean)
2020-04-29/c10_n20000.txt:Requests per second:    6.64 [#/sec] (mean)
2020-04-29/c15_n30000.txt:Requests per second:    7.87 [#/sec] (mean)
2020-04-29/c20_n40000.txt:Requests per second:    8.38 [#/sec] (mean)
2020-04-29/c25_n50000.txt:Requests per second:    8.37 [#/sec] (mean)
2020-04-29/c30_n60000.txt:Requests per second:    8.00 [#/sec] (mean)

```

### 2020-04-28

**Front-end: t3a.xlarge** (Burstable, AMD EPYC 4 vCPU, 16 GB RAM, 5 Gbps Network)  
**Back-end: r5a.xlarge** (Memory Optimized, AMD EPYC 4 vCPU, 32 GB RAM, 2880 Mbps EBS, 10 Gbps Network)  

```
$ grep 'Requests per second' 2020-04-28/*
2020-04-28/c05_n10000.txt:Requests per second:    4.55 [#/sec] (mean)
2020-04-28/c10_n20000.txt:Requests per second:    7.48 [#/sec] (mean)
2020-04-28/c15_n30000.txt:Requests per second:    8.50 [#/sec] (mean)
2020-04-28/c20_n40000.txt:Requests per second:    8.87 [#/sec] (mean)
2020-04-28/c25_n50000.txt:Requests per second:    9.10 [#/sec] (mean)
2020-04-28/c30_n60000.txt:Requests per second:    9.22 [#/sec] (mean)
```

### 2020-03-30

**Front-end: m4.2xlarge** (General Purpose, Intel Xeon 8 vCPU, 32 GB RAM, 1000 Mbps EBS, High Network)  
**Back-end: c4.4xlarge** (Compute Optimized, Intel Xeon 16 vCPU, 30 GB RAM, 2000 Mbps EBS, High Network)  

```
$ grep 'Requests per second' 2020-03-30/*
2020-03-30/c10_n20000.txt:Requests per second:    7.51 [#/sec] (mean)
2020-03-30/c15_n30000.txt:Requests per second:    9.76 [#/sec] (mean)
2020-03-30/c20_n40000.txt:Requests per second:    10.20 [#/sec] (mean)
2020-03-30/c25_n50000.txt:Requests per second:    9.59 [#/sec] (mean)
2020-03-30/c30_n60000.txt:Requests per second:    10.95 [#/sec] (mean)
```
