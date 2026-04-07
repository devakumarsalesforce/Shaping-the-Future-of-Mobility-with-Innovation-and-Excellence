global class TestDriveReminder implements Schedulable {

    global void execute(SchedulableContext sc) {

        List<Vehicle_Order__c> testDrives = [
            SELECT Id, Customer_Email__c, Test_Drive_Date__c 
            FROM Vehicle_Order__c 
            WHERE Test_Drive_Date__c = TODAY + 1
        ];

        for (Vehicle_Order__c o : testDrives) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { o.Customer_Email__c });
            mail.setSubject('Your Test Drive Reminder');
            mail.setPlainTextBody('Hi, this is a reminder for your test drive tomorrow.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
}
