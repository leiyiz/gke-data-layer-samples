import os
import json

RESULT_FOLDER = './ssd/150gi_50_pod_small'

GPU = 'train_au_percentage'
M_GPU = 'train_au_mean_percentage'
SAMPLE_THROUGHPUT = 'train_throughput_samples_per_second'
M_SAMPLE_THROUGHPUT = 'train_throughput_mean_samples_per_second'
M_MB = "train_io_mean_MB_per_second"

def average(numbers):
  return sum(numbers) / len(numbers)

def process_summary(summary):
    metric = summary['metric']
    gpu = metric[M_GPU]
    spp = metric[M_SAMPLE_THROUGHPUT]
    mmb = metric[M_MB]
    fe_gpu_percentage = metric[GPU][0]
    fe_samples_per_second = metric[SAMPLE_THROUGHPUT][0]
    sub_gpu_percentage = average(metric[GPU][1:])
    sub_spp = average(metric[SAMPLE_THROUGHPUT][1:])

    return fe_gpu_percentage, fe_samples_per_second, sub_gpu_percentage, sub_spp, gpu, spp, mmb



results = []

for root, dirs, files in os.walk(RESULT_FOLDER):
    for file in files:
        if file == 'summary.json':
            with open(root +'/'+ file) as f:
                # total_pod+= 1
                d = json.load(f)
                results.append(process_summary(d))

print(list(map(average, zip(*results))))
