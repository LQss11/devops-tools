 Jenkins .instance.getItemByFullName("JobName")
        .getBuildByNumber(90)
        .finish(hudson.model.Result.ABORTED, new java.io.IOException("Aborting build")); 
