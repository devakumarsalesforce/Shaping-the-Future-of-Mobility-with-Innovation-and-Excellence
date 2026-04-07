// Run daily at 6 AM
System.schedule('Daily Order Processing', '0 0 6 * * ?', new OrderProcessingScheduler());

// Run test drive reminders every day at 7 AM
System.schedule('Test Drive Reminder', '0 0 7 * * ?', new TestDriveReminder());
