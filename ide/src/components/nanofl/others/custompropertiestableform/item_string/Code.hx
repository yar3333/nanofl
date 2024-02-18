package components.nanofl.others.custompropertiestableform.item_string;

class Code extends components.nanofl.others.custompropertiespane.item_string.Code
{
    override function attachNode(node:js.html.Element, parentNode:js.JQuery, attachMode:wquery.AttachMode)
    {
        super.attachNode(node.firstElementChild.firstElementChild.firstElementChild, parentNode, attachMode);
    }
}