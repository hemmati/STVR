iterate.cluster <- function(s=NULL,  # If calling this function a second time, this should be
                        # resulting object of the first
                        testDir=NULL,  # Name of the directory with the preprocessed test files
                        testNamesMap=NULL,  # testing map
                        truthName=NULL, # ground truth (fault matrix)
                        kDir="",
                        iter=10,   # LDA parameter number of iterations
                        alpha=0.1,  # LDA parameter alpha
                        beta=0.1,  #LDA parameter beta                        
                        distance,  # distance measure to use (passed to dist())
                        maximization, # max. algorithm to use (greedy or clustering)
                        rerunLDA=FALSE, # Should we rerun LDA, if it's already been run?
                        verbose=FALSE,
                        iT=30,
                        method="cluster_string")
{
  
  names <- c("15 for Tablets","16","16 for Tablets","17","17 Tablets","18","18 Tablets","19","19 Tablets","20","20 Tablets","21","21 Tablet","22","22 Tablet","23","23 Tablet","24","24 Tablet","25","25 Tablet","26","26 Tablet","27","27 Tablet","28","28 Tablet","29","29 Tablet","30 Tablet");
  #names <- c("80");
  apfds <-matrix(nrow=length(names),ncol=iT);
  for(m in 1:length(names)){
    testDir2=paste("/home/zhihan/Workspace/STVR/data/LDA_INPUT_DATA/Mobile Firefox/",names[m],"/",sep="");
    clusterDir2=paste("/home/zhihan/Workspace/STVR/data/LDA_LAYERIZED_DATA/Mobile Firefox/",names[m],"/",sep="");
    
    #testDir2=paste(testDir2,"/",sep="");
    truthName2=paste("/home/zhihan/Workspace/STVR/data/FAULT_MATRIX/Mobile Firefox/",names[m],"/fault_matrix.txt",sep="");
    
    #truthName2=(truthName2,"/fault_matrix.txt");
    dirname = paste("/home/zhihan/Workspace/STVR/data/RESULT/Mobile Firefox/",kDir,sep="");
    if(!file.exists(dirname)){
      dir.create(dirname,recursive = TRUE);
    }
    filename = paste("/home/zhihan/Workspace/STVR/data/RESULT/Mobile Firefox/",kDir,"",names[m],".txt",sep="");
    sink(filename);
    
    for(n in 1:iT)
    {
      
     # print(clusterDir2)
      if(method=="string")
      {
        tcp <- tcp.string(testDir=testDir2,truthName=truthName2);
      }else if(method=="random")
      {
        tcp <- tcp.random(testDir=testDir2,truthName=truthName2);
      }else if(method=="cluster_random")
      {
        tcp <- random.cluster(testDir=testDir2,truthName=truthName2, testDirCluster = clusterDir2);
      }else if(method=="cluster_string")
      {
        tcp <- string.cluster(testDir=testDir2,truthName=truthName2, testDirCluster = clusterDir2);
      }
      #topic <- tcp.lda(testDir,K,truthName);
      apfds[m,n] <- tcp$apfd;
     # print(tcp$apfd)
      
      
    }
    
    apfds[m,]=sort(apfds[m,])
 #   print( apfds[m,]);
    
   # print('medium:');
    
    medium_point=(iT+1)/2;
    if(is.integer(medium_point))
    {
      medium=apfds[m,medium_point];
    }else{
      medium=(apfds[m,(iT+2)/2]+apfds[m,iT/2])/2;
    }
    
    print(medium);
    sink();
    
    
  }
  apfds
}


iterate.cluster.all <- function(itNum=3)
{
  
  
 #methods=c("cluster_random","string","random");
 methods=c("cluster_string","cluster_random","string","random");
# methods=c("cluster_string");
  for(i in 1:length(methods)){
    
    dirName = paste(methods[i],"/",sep="")
    iterate.cluster(iT=itNum,method=methods[i],kDir=dirName);
  }
}
