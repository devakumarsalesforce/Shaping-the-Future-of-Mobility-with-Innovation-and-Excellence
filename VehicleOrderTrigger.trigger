trigger VehicleOrderTrigger on Vehicle_Order__c (before insert, before update, after insert) {

    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            VehicleOrderTriggerHandler.validateStock(Trigger.new);
        }
    }

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            VehicleOrderTriggerHandler.autoAssignDealer(Trigger.new);
        }
    }
}
