# Startup messages
#' @importFrom utils packageVersion

.onAttach <- function(lib, pkg, ...){
  startup_msg <- paste0("Welcome to mde. This is mde version ",
                        packageVersion("mde"),".\n",
              " Please file issues and feedback at https://www.github.com/Nelson-Gon/mde/issues\n",
              "Turn this message off using 'suppressPackageStartupMessages(library(mde))'\n",
              " Happy Exploration :)")
  packageStartupMessage(startup_msg)
}
