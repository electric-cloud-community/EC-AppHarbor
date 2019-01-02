package ecplugins.EC_AppHarbor.client;

import com.google.gwt.core.client.JavaScriptObject;

import com.electriccloud.commander.gwt.client.Component;
import com.electriccloud.commander.gwt.client.ComponentBaseFactory;
import com.electriccloud.commander.gwt.client.ComponentContext;
import org.jetbrains.annotations.NotNull;

public class ParameterPanelFactory extends ComponentBaseFactory
{
    @NotNull
    @Override
    public Component createComponent(ComponentContext jso)
    {
        String className = ParameterPanelFactory.getComponentName();
        Component oComponent = null;
        if(className.equals("ListApplicationsParameterPanel")){
            oComponent = new ListApplicationsParameterPanel();
        }else if(className.equals("ListErrorsParameterPanel")){
            oComponent = new ListErrorsParameterPanel();
        }else if(className.equals("ListCollaboratorParameterPanel")){
            oComponent = new ListCollaboratorParameterPanel();
        }else if(className.equals("ListConfigurationParameterPanel")){
            oComponent = new ListConfigurationParameterPanel();
        }else if(className.equals("ListHostNamesParameterPanel")){
            oComponent = new ListHostNamesParameterPanel(); 
        }else if(className.equals("ListServiceHooksParameterPanel")){
            oComponent = new ListServiceHooksParameterPanel();
        }else{//BuildsActions
            oComponent = new BuildsActionsParameterPanel();
        }
        return oComponent;
    }
}
