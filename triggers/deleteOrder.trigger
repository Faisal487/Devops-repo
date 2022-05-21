trigger deleteOrder on Order__c (after delete) {
    List<Order__c> orde = [select Quantity__c,Product__r.Units_Available__c from Order__c where id in : Trigger.old];
    
    List<Product__c>p2 = new List<Product__c>();
    
    for(Order__c o2:orde){   // Order 1
        Order__c old = (Order__c)Trigger.oldMap.get(o2.id); 
        o2.Product__r.Units_Available__c += old.Quantity__c;
        p2.add(o2.Product__r);
    }
    update p2;
}