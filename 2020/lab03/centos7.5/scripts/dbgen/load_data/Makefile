TARGETS = load \
	  unload

all: $(TARGETS) 

%: %.sh
	cp $< $@ && chmod +x $@

push:
	ssh dbxa rm -rf '/tmp/foo/*'
	scp -r * dbxa:/tmp/foo

clean:
	rm -rf $(TARGETS)
	rm -f *.log
