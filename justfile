set shell := ['nu', '-c']

# Lists all
default:
	just --list

# Builds all
build: styles fonts snippets

# Linebreaks should be escaped here, for each line is executed separately

styles: style slidy print

style:
	sass 'src/style.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	save -f "target/style.html"

slidy:
	sass 'src/slidy.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	save -f "target/slidy.html"

print:
	sass 'src/print.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	$"(open -r $"($env.HOME)/css/lib/paged-snippet.html")" + $in | \
	save -f "target/print.html"

fonts: sans serif

sans:
	sass 'src/font-sans.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	save -f "target/font-sans.html"

serif:
	sass 'src/font-serif.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	save -f "target/font-serif.html"

snippets: aside glossing hiero cjtypo-sans cjtypo-serif

aside:
	sass 'src/aside.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	save -f "target/aside.html"

glossing:
	sass 'src/glossing.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	save -f "target/glossing.html"

hiero:
	sass 'src/hiero.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	save -f "target/hiero.html"

cjtypo-sans:
	sass 'src/cjtypo-sans.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	$"(open -r $"($env.HOME)/css/lib/cjtypo-snippet.html")" + $in | \
	save -f "target/cjtypo-sans.html"

cjtypo-serif:
	sass 'src/cjtypo-serif.scss' | cleancss -O2 | "<style>\n" + $in + "\n</style>" | \
	$"(open -r $"($env.HOME)/css/lib/cjtypo-snippet.html")" + $in | \
	save -f "target/cjtypo-serif.html"
