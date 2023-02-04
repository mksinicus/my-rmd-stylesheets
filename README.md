# mksinicus's stylesheet for R Markdown generated documents

My stylesheets for R Markdown with output for HTML page, printable media, and
presentation with W3C Slidy.

## Build and usage

You will need [Dart SASS](https://sass-lang.com/dart-sass) and [Just](https://github.com/casey/just)
to build, and [Clean CSS](https://github.com/clean-css/clean-css) to minimize.
I personally use Nushell, but I believe it would be easy to translate these
building commands into Bash. Or you can just download the output inside the
`target/` directory.

However, these styles are to be used with my template files, which are not 
open-source (yet).

## Third-party contents

This project uses code and artifacts from [CJ Typographer](https://github.com/hiugiak/cj-typo)
by Zhou Xiaojie and [Paged.js](https://pagedjs.org/) by Adam Hyde. Both are 
distributed under MIT license. In this project, any use of these are either
placed inside the directory `third-party/` or explicitly marked in context.

## Non-Gittish notice

I currently find [Pijul](https://pijul.org) more reliable for version control,
so I would like to move all my personal projects to Pijul. However, GitHub is
a popular place, so my projects will stay but possibly only updated with not so
carefully arranged commits, say, simply with `git add .` and
`git commit -m <version message>`. Feel free to pull and inspect if you use
Pijul too; I included the `.pijul` path.
