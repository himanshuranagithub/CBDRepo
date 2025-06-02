({
	// Fetch the accounts from the Apex controller
	getAccountList : function(component, event, helper) {
        var action = component.get('c.getAccounts');
        var self = this;
        action.setCallback(this, function(actionResult){
            component.set('v.accounts', actionResult.getReturnValue());
        });
         
        $A.enqueueAction(action);
	}
})