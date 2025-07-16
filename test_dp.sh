split=navhard
agent=gtrs_diffusion_policy
dir=train_dp
metric_cache_path="${NAVSIM_EXP_ROOT}/metric_cache"
cd ${NAVSIM_DEVKIT_ROOT}

for epoch in 49; do
    padded_epoch=$(printf "%02d" $epoch)
    experiment_name="${dir}/test-${padded_epoch}ep-${split}-random"
    #ckpt=${NAVSIM_EXP_ROOT}/${dir}/epoch${padded_epoch}.ckpt # this can also be the checkpoint we provided
    ckpt=${NAVSIM_EXP_ROOT}/gtrs_dp.ckpt
    export DP_PREDS=none
    export SUBSCORE_PATH=${NAVSIM_EXP_ROOT}/${dir}/epoch${epoch}_${split}.pkl # save path for the dp-generated trajectories

    python ${NAVSIM_DEVKIT_ROOT}/navsim/planning/script/run_pdm_score_gpu_v2.py \
        agent=$agent \
        dataloader.params.batch_size=32 \
        agent.checkpoint_path=${ckpt} \
        trainer.params.precision=32 \
        experiment_name=${experiment_name} \
        +cache_path=null \
        metric_cache_path=${metric_cache_path} \
        train_test_split=${split}_two_stage
done