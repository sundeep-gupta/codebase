import org.apache.log4j.Logger;

public class Log4JExample {
    /** Creates a new instance of SimpleLogging */
    public Log4JExample() {
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Logger logger =Logger.getLogger("name");
        logger.info("Hello this is an info message");
    }
}
           
