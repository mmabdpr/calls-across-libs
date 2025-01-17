library(dplyr)
library(tidyr)

file_list = list.files(path="Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data", recursive = TRUE, pattern="*-invocations.tsv", full.names = TRUE)
writeLines("CallerLibrary\tCallerMethod\tDeclaredCalleeMethod\tDeclaredCalleeLibrary\tActualCalleeMethod\tActualCalleeLibrary\tCalleeVisibility\tServiceBypass\tCounts","Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data/RQ2-serviceBypasses.tsv")
for (i in seq_along(file_list)) {
  filename = file_list[[i]]
  df <- read.csv(filename, sep='\t')
  # RQ2a - ServiceLoader + Casts
  reflDf <- df[df$Service.Bypass == "cast", ]
  counts = reflDf %>% group_by(Caller.Library, Caller.Method, Declared.Callee.Method, Declared.Callee.Library, Actual.Callee.Method, Actual.Callee.Library, Callee.Visibility,Service.Bypass) %>% summarise(Count = n())  %>% drop_na()
  write.table(counts,"Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data/RQ2-serviceBypasses.tsv",sep="\t",row.names=FALSE, col.names=FALSE, append=TRUE)
  
  # RQ2b - ServiceLoader + Instantiations
  reflDf <- df[df$Service.Bypass == "instantiation", ]
  counts = reflDf %>% group_by(Caller.Library, Caller.Method, Declared.Callee.Method, Declared.Callee.Library, Actual.Callee.Method, Actual.Callee.Library, Callee.Visibility,Service.Bypass) %>% summarise(Count = n())  %>% drop_na()
  write.table(counts,"Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data/RQ2-serviceBypasses.tsv",sep="\t",row.names=FALSE, col.names=FALSE, append=TRUE)
  
  # RQ2c - ServiceLoader + Reflection
  reflDf <- df[df$Service.Bypass == "reflection", ]
  counts = reflDf %>% group_by(Caller.Library, Caller.Method, Declared.Callee.Method, Declared.Callee.Library, Actual.Callee.Method, Actual.Callee.Library, Callee.Visibility,Service.Bypass) %>% summarise(Count = n())  %>% drop_na()
  write.table(counts,"Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data/RQ2-serviceBypasses.tsv",sep="\t",row.names=FALSE, col.names=FALSE, append=TRUE)
}

# RQ2 - serviceBypassCalls
file_list = list.files(path="Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data", recursive = TRUE, pattern="*-serviceBypassCalls.tsv", full.names = TRUE)
writeLines("CallerLibrary\tCallerMethod\tInterfaceLibrary\tInterfaceName\tImplName\tImplLibrary\tCalleeMethod\tCounts","Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data/RQ2-serviceBypassCalls.tsv")
for (i in seq_along(file_list)) {
  filename = file_list[[i]]
  print(filename)
  df <- read.csv(filename, sep='\t')
  counts = df %>% group_by(Caller.Library, Caller.Method, Interface.Library, Interface.Name, Impl..Name, Impl..Library, Callee.Method ) %>% summarise(Count = n())
  print(counts)
  write.table(counts,"Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data/RQ2-serviceBypassMethods.tsv",sep="\t",row.names=FALSE, col.names=FALSE, append=TRUE)
}

# RQ2d - setAccessible
file_list = list.files(path="Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data", recursive = TRUE, pattern="*-setAccessibleCalls.tsv", full.names = TRUE)
writeLines("CallerLibrary\tCallerMethod\tCalleeLibrary\tsetAccessible.CalledOn\tVisibility\tCalleeName\tFieldSignature\tCounts","Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data/visual-data/RQ2-setAccessibleCalls.tsv")
for (i in seq_along(file_list)) {
  filename = file_list[[i]]
  print(filename)
  df <- read.csv(filename, sep='\t')
  filteredDf = filter(df, Caller.Library != Callee.Library, !grepl("unknownLib", Caller.Library, fixed=TRUE), !grepl("unknownLib", Callee.Library, fixed=TRUE))
  counts = filteredDf %>% group_by(Caller.Library, Caller.Method, Callee.Library, setAccessible.Called.On, Visibility, Callee.Name, Field.Signature) %>% summarise(Count = n())
  write.table(counts,"Documents/Waterloo/PL/calls-across-libs/libs-info-project-runner/api-surface-data/visual-data/RQ2-setAccessibleCalls.tsv",sep="\t",row.names=FALSE, col.names=FALSE, append=TRUE)
}

