library(testicles)
#dd = tempdir(check=TRUE)
dd = "test.rticles.formats.dir"
dir.create(dd)
xx = draft.list.templates(target.dir=dd)
file.remove(xx$rmd.filenames[1])
yy = render.list.rmd(xx$rmd.filenames)
