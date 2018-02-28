# CIS Ubuntu Linux 14.04 LTS Benchmark v2 InSpec Profile

This example shows the implementation of an InSpec profile.
## Description

This profile implements the [CIS Ubuntu Linux 14.04 LTS Benchmark (v2.0.0)](https://www.cisecurity.org/benchmark/ubuntu_linux/)

## How to run this inspec exec remotely

```
cd cis-ubuntu-14.04-benchmark
inspec exec ./ -t $SSHCONN -i $SSHKEY --sudo --format=progress

```

To compute compliance score you could run `inspec exec` like below

```
inspec exec ./ -t $SSHCONN -i $SSHKEY --sudo --format=progress \
    | grep -E 'examples.*failures.*pending' \
    | awk '{ s = 100 * ($1 - $3) / $1; print "Summary: " $0 "\nCompliance score: " s "%" }'
```

Or for a local run

```
inspec exec <cis_benchmark_test_dir> --format=progress \
  | grep -E 'examples.*failures.*pending' \
  | awk '{ s = 100 * ($1 - $3) / $1; print "Summary: " $0 "\n%Compliance: " s }'
```

