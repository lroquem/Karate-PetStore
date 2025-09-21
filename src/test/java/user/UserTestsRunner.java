package user;

import com.intuit.karate.Runner;

public class UserTestsRunner {
    public static void main(String[] args) {
        Runner.path("src/test/java/user/CrearUser.feature",
                        "src/test/java/user/ObtenerUser.feature",
                        "src/test/java/user/ModificarUser.feature"
                )
                .outputCucumberJson(true)
                .parallel(1);
    }
}
