TARGETS	= runtest

all: $(TARGETS)

.PHONY: clean clobber cl run

%: %.sh
	cp $< $@
	chmod +x $@

clean:
clobber: clean
	rm -f $(TARGETS)
cl: clobber

run: runtest
	(cd ../utils; make cl; make)
	./runtest
