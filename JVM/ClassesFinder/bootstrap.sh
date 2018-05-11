# $1 is java itself, $2 is the library path that you want to search, $3 is the class name you want to search
# example: ./bootstrap.sh /apollo/env/ChimeraWebsite/jdk/bin/java /apollo/env/ChimeraWebsite/lib com.amazon.identity.cvf.verification.AbstractVerificationController
$1 -cp ClassesFinder-1.0-SNAPSHOT-jar-with-dependencies.jar -Djava.ext.dirs=$2 com.zhc.tools.ClassesFinder $3

