
for seed in 0 9 11 30 69
do
  for num_ex in 1000 500 2000
  do
    CUDA_VISIBLE_DEVICES=7 python3 smat/train.py \
      --task imdb \
      --setup static_teacher \
      --arch electra \
      --tokenizer electra \
      --explainer attention_explainer \
      --explainer-params "{\"normalizer_fn\": \"softmax\", \"normalize_head_coeffs\": \"sparsemax\", \"aggregator_idx\": \"mean\", \"aggregator_dim\": \"row\", \"layer_idx\": null, \"head_idx\": null}" \
      --teacher-explainer gradient_input_explainer \
      --teacher-explainer-params "{\"normalizer_fn\": \"softmax\", \"ord\": 2}" \
      --initialize-embeddings \
      --optimizer sgd \
      --patience 10 \
      --learning-rate 5e-3 \
      --num-examples ${num_ex} \
      --kld-coeff 0.2 \
      --meta-interval 1 \
      --meta-lr 5e-3 \
      --warmup-steps 0 \
      --num-resets 0 \
      --batch-size 32 \
      --teacher-dir /home/mtreviso/meta-expl/saved-models/imdb-electra-models/teacher_dir \
      --seed ${seed} \
      --wandb meta-expl
  done
done
