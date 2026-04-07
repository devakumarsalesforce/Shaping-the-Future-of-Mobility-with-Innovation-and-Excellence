public class VehicleStockBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Stock__c, Incoming_Stock__c FROM Vehicle_Model__c');
    }

    public void execute(Database.BatchableContext bc, List<Vehicle_Model__c> scope) {
        for (Vehicle_Model__c m : scope) {
            m.Stock__c += m.Incoming_Stock__c;
            m.Incoming_Stock__c = 0;
        }
        update scope;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Stock update completed.');
    }
}
