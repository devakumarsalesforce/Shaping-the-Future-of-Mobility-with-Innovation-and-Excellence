global class OrderProcessingScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        List<Vehicle_Order__c> pendingOrders = [
            SELECT Id, Status__c 
            FROM Vehicle_Order__c 
            WHERE Status__c = 'Pending'
        ];

        for (Vehicle_Order__c o : pendingOrders) {
            o.Status__c = 'Processing';
        }

        update pendingOrders;
    }
}
