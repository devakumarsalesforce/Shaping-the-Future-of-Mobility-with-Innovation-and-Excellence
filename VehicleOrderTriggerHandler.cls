public class VehicleOrderTriggerHandler {

    // Validate vehicle stock before order is created
    public static void validateStock(List<Vehicle_Order__c> orders) {
        Set<Id> modelIds = new Set<Id>();
        for (Vehicle_Order__c o : orders) {
            modelIds.add(o.Vehicle_Model__c);
        }

        Map<Id, Vehicle_Model__c> modelMap = new Map<Id, Vehicle_Model__c>(
            [SELECT Id, Name, Stock__c FROM Vehicle_Model__c WHERE Id IN :modelIds]
        );

        for (Vehicle_Order__c o : orders) {
            Vehicle_Model__c model = modelMap.get(o.Vehicle_Model__c);

            if (model.Stock__c <= 0) {
                o.addError('This vehicle model is out of stock.');
            }
        }
    }

    // Assign nearest dealer automatically
    public static void autoAssignDealer(List<Vehicle_Order__c> orders) {
        List<Dealer__c> dealers = [SELECT Id, Name, Location__c FROM Dealer__c];

        for (Vehicle_Order__c o : orders) {
            Decimal bestDistance = 999999;
            Id assignedDealer;

            for (Dealer__c d : dealers) {
                Decimal distance = GeoLocationUtil.calculateDistance(o.Customer_Location__c, d.Location__c);
                if (distance < bestDistance) {
                    bestDistance = distance;
                    assignedDealer = d.Id;
                }
            }

            if (assignedDealer != null) {
                o.Dealer__c = assignedDealer;
            }
        }

        update orders;
    }
}
