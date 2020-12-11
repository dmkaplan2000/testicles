#' Function to return a list of Rmarkdown templates in a package
#'
#' @export
list.rmarkdown.templates = function(package="rticles") {
  pd = system.file(package=package)
  td = file.path(pd,"rmarkdown","templates")
  return(list.dirs(td,full.names=FALSE,recursive=FALSE))
}

#' Checkout a list of Rmarkdown templates
#'
#' @export
draft.list.templates = function(templates=list.rmarkdown.templates(package=package),
                                package="rticles",
                                target.dir=tempdir(check=TRUE)) {
  owd = getwd()
  on.exit(setwd(owd))
  setwd(target.dir)
  for (tn in templates) {
    rmarkdown::draft(file=tn,template=tn,package=package,create_dir=TRUE,edit=FALSE)
  }

  # Not checking these were actually created
  rmd.filenames = file.path(target.dir,templates,paste0(templates,".Rmd"))

  return(list(target.dir=target.dir,templates=templates,package=package,
              rmd.filenames=rmd.filenames))
}

#' Render list of Rmd files, capturing output and turning errors into warnings
#'
#' @export
render.list.rmd = function(rmd.files,render.args=list()) {
  tt = tempfile()
  tf = file(tt,open="wt")

  sink(tf)
  on.exit(sink(),add=TRUE)
  sink(tf,type="message")
  on.exit(sink(type="message"),add=TRUE)

  es = list()
  for (fn in rmd.files) {
    args = list(input=fn,envir=new.env())
    ra = render.args[[fn]]
    if (!is.null(ra))
      args = c(args,ra)

    cat("\n=========================== Rendering",fn,"=============================\n")
    t = try(do.call(rmarkdown::render,args))
    if (inherits(t,"try-error")) {
      warning("Error while rendering",fn,":",t)
      es[[fn]] = t
    }
    cat("\n=========================== Done with",fn,"=============================\n")
  }

  return(list(output=readLines(tt),errors=es))
}
