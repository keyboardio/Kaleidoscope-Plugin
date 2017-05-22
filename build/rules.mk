EXTRA_BUILDER_ARGS="-libraries ."

.phony:


astyle:
	find . -type f -name \*.cpp |xargs -n 1 astyle --style=google
	find . -type f -name \*.ino |xargs -n 1 astyle --style=google
	find . -type f -name \*.h |xargs -n 1 astyle --style=google

	
%:	
	../Kaleidoscope/tools/kaleidoscope-builder $@
