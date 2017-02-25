python tools/train_faster_rcnn_alt_opt.py --gpu=1 --net_name=VGG16 --weights=data/imagenet_models/VGG16.v2.caffemodel --imdb=voc_2007_trainval 2>&1 | tee LOG/pascal_origin_480640.log
