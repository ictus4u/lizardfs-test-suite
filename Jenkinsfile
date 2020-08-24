def buildDockerImageWithCache(
    imageName,
    imageTag,
    imageBuildCommand,
    dockerRegistry,
    dockerRegistrySecretId = ''){
        docker.withRegistry(dockerRegistry, dockerRegistrySecretId) {
            distImage = docker.image("${imageName}:latest")
            try{
                baseImage.pull()
            }
            catch(err){
                true
            }
            imageBuildCommand = "--cache-from ${imageName}:latest " + imageBuildCommand
            baseImage = docker.build(imageName, imageBuildCommand)
            baseImage.push(imageTag)
            baseImage.push("latest")
        }
}

node {
    def baseImage
    def distImage
    def dockerRegistrySecretId = '45d995a9-803d-4dce-9f16-a39165e867ea'
    def dockerRegistry = 'https://registry.aleph.engineering'
    def tag="${GIT_BRANCH}-${env.BUILD_ID}"
    def buildPrefix = "--build-arg LIZARD_DIST_REPOSITORY=registry.aleph.engineering/lizardfs-dist:${tag} --build-arg LIZARD_BASE_REPOSITORY=registry.aleph.engineering/lizardfs-base:${tag} "
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
        buildDockerImageWithCache(imageName, tag, imageBuildCommand, dockerRegistry, dockerRegistrySecretId)
    }

    stage('Build dist image') {
        def imageName = "lizardfs-dist"
        def imageBuildCommand = "-f services/lizardfs-dist/Dockerfile ."
        buildDockerImageWithCache(imageName, tag, imageBuildCommand, dockerRegistry, dockerRegistrySecretId)
    }

    stage('Build master image') {
        def imageName = "lizardfs-master"
        def imageBuildCommand = buildPrefix + "./services/lizardfs-master"
        buildDockerImageWithCache(imageName, tag, imageBuildCommand, dockerRegistry, dockerRegistrySecretId)
    }
}
