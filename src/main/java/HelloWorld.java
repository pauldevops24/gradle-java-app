public class HelloWorld {
    public static void main(String[] args) {
        while (true) {
            System.out.println("Application is running...");
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                break;
            }
        }
    }
}