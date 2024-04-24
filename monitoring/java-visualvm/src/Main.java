public final class Main {
	public static void main(String[] args) {
		while (true) {
			try {
				Thread.sleep(3000);
				System.out.println("Hello, World");
			} catch (InterruptedException e) {
				break;
			}
		}
	}
}