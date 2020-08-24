def buildDockerImageWithCache(
    imageName,
    imageBuildCommand,
    dockerRegistry,
    dockerRegistrySecretId = ''){
        docker.withRegistry(dockerRegistry, dockerRegistrySecretId) {
            distImage = docker.image(imageName + ":latest")
            try{
               baseImage.pull()
            }
            catch(err){
                true
            }
            baseImage = docker.build(imageName, imageBuildCommand)
            baseImage.push("${env.BUILD_ID}")
            baseImage.push("latest")
        }
}

node {
    def baseImage
    def distImage
    def dockerRegistrySecretId = '45d995a9-803d-4dce-9f16-a39165e867ea'
    def dockerRegistry = 'https://registry.aleph.engineering'

    stage('Clone repository') {
        checkout scm
    }

    stage('Clone build sources') {
        dir('vendors/lizardfs') {
            git branch: 'master', url: 'https://github.com/lizardfs/lizardfs.git'
        }
    }

    stage('Build base image') {
        def imageName = "lizardfs-base"
        def imageBuildCommand = "./services/lizardfs-base"
        buildDockerImageWithCache(imageName, imageBuildCommand, dockerRegistry, dockerRegistrySecretId)
    }

    stage('Build dist image') {
        def imageName = "lizardfs-dist"
        def imageBuildCommand = "--cache-from lizardfs-dist:latest -f services/lizardfs-dist/Dockerfile ."
        buildDockerImageWithCache(imageName, imageBuildCommand, dockerRegistry, dockerRegistrySecretId)
    }
}
