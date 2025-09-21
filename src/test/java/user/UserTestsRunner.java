package user;

import com.intuit.karate.Runner;

public class UserTestsRunner {
    public static void main(String[] args) {
        Runner.path("src/test/java/user")
                .outputCucumberJson(true)
                .parallel(1);
    }
}
