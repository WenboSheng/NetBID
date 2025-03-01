% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pipeline_functions.R
\name{NetBID.analysis.dir.create}
\alias{NetBID.analysis.dir.create}
\title{Manipulation of Working Directories for NetBID2 Driver Estimation Step}
\usage{
NetBID.analysis.dir.create(project_main_dir = NULL,
  project_name = NULL, network_dir = NULL,
  network_project_name = NULL, tf.network.file = NULL,
  sig.network.file = NULL)
}
\arguments{
\item{project_main_dir}{character, name or absolute path of the main working directory for driver analysis.}

\item{project_name}{character, name of the project folder.}

\item{network_dir}{character, name or absolute path of the main working directory for network construction.}

\item{network_project_name}{character, the project name of network construction. Or use the project name of SJARACNe.
This parameter is optional. If one didn't run NetBID2 network construction part in the pipeline, he could set it to NULL.
If one like to follow the NetBID2 pipeline, he should set it to the path of the TF network file and the SIG network file.}

\item{tf.network.file}{character, the path of the TF network file (e.g. "XXX/consensus_network_ncol_.txt").
Default is the path of network_project_name.}

\item{sig.network.file}{character, the path of the SIG network file (e.g. "XXX/consensus_network_ncol_.txt").
Default is the path of network_project_name.}
}
\value{
Returns a list object, containing main.dir (path of the main working directory), project.name (project name),
out.dir (path of the project folder, which contains three subfolders), out.dir.QC, out.dir.DATA and out.dir.PLOT.
}
\description{
\code{NetBID.analysis.dir.create} is used to help users create an organized working directory
for the driver estimation step in NetBID2 analysis.
However, it is not essential for the analysis.
It creates a hierarchcial working directory and returns a list contains this directory information.
}
\details{
This function requires user to define the main working directory and the project’s name.
It creates a main working directory with a subdirectory of the project.
It also automatically creates three subfolders (QC, DATA and PLOT) within the project folder.
QC/, storing Quality Control related plots; DATA/, saving data in RData format; PLOT/, storing output plots.
This function also returns a list object (e.g. \code{analysis.par} in the demo) with directory information wrapped inside.
This list is an essential for driver construction step, all the important intermediate data generated later will be wrapped inside.
}
\examples{

\dontrun{
network.dir <- sprintf('\%s/demo1/network/',system.file(package = "NetBID2")) # use demo
network.project.name <- 'project_2019-02-14' #
project_main_dir <- 'demo1/'
project_name <- 'driver_test'
analysis.par  <- NetBID.analysis.dir.create(project_main_dir=project_main_dir,
                                            project_name=project_name,
                                            network_dir=network.dir,
                                            network_project_name=network.project.name)
}
}
