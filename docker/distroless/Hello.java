class Hello
{
    public static void main(String[] args)
    {
        System.out.println("Hello world.");

        // Get the username of the user running this file
        String userName = System.getProperty("user.name");
        System.out.println("Running as user: " + userName);

        try
        {
            // Sleep for 600 seconds (600,000 milliseconds)
            Thread.sleep(600000);
        }
        catch (InterruptedException e)
        {
            // Handle the exception if the sleep is interrupted
            e.printStackTrace();
        }
    }
}
