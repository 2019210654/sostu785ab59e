TARGETS	= recm

all: $(TARGETS)

.PHONY: clean clobber cl check test

%: %.py
	cp $< $@
	chmod +x $@

clean:
clobber: clean
	rm -f $(TARGETS)
cl: clobber

check:
	pep8 *.py

test: recm check
	./recm -v ../data/matrix.txt
