package components.nanofl.others.custompropertiestableform.item_info;

class Code extends components.nanofl.others.custompropertiespane.item_info.Code
{
    override function attachNode(node:js.html.Element, parentNode:js.JQuery, attachMode:wquery.AttachMode)
    {
        super.attachNode(node.firstElementChild.firstElementChild.firstElementChild, parentNode, attachMode);
    }
}