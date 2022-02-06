PWD=$(shell pwd)
NAME=$(shell basename $(PWD))
IMAGE=$(NAME)
TAG=local
JUPYTER_IP=0.0.0.0
JUPYTER_PORT=8780

.PHONY: start-notebook readme

start-notebook:
	docker run --name $(NAME) --rm -it -v $(PWD):/src -p $(JUPYTER_PORT):$(JUPYTER_PORT) $(IMAGE):$(TAG) jupyter notebook --ip $(JUPYTER_IP) --port $(JUPYTER_PORT) --allow-root

readme:
	pandoc --to html --metadata pagetitle=README --standalone README.md --output README.html

%.html : %.ipynb
	jupyter nbconvert $< --to html --template classic

include Makefile.defs
