/**
 * an item in my list
 */
class ListItemView extends Backbone.View<Backbone.Model> {
	static model = Backbone.Model;
	constructor(options) {
		super(options);
        this.delegateEvents({
            "click .delete" : "triggerDelete"
        });
		var element = $('<li><span></span> <a class="btn btn-small delete">delete</a></li>').addClass(this.model.get('index')%2?'even':'odd');
		this.$el.append(element);
		element.find('span').text(this.model.get('value') + ' @index: ' + this.model.get('index'));
	}
	private triggerDelete() {
		this.trigger('delete', this.model.get('value'));
	}
}

/**
 * list demo view
 */
class ListView extends Backbone.View<Backbone.Model> {

	initialize(options) {
		this.$el.html(options.template({}));
		this.model = new Backbone.Model();
		Backbone.Components.mapToView(this,[
			// list magic
			Backbone.Components.List.map('ul', ListItemView)
				.addBehaviour(Backbone.Components.Behaviours.ListItemEventHandler.getFactory('delete', (itemValue) => {
					this.model.set('testItems', _.without(_.clone(this.model.get('testItems')), itemValue));
					if(this.model.get('testItems').length == 0) {
						this.makeRandomItems();
					}
				}))
		]);
		this.makeRandomItems();
	}

	makeRandomItems() {
		// functional loop :>
		var rnd = function(items:string[] = [], count:number = 10) {
			items.push('item ' + (items.length + 1));
			if(items.length < count) {
				items = rnd(items, count);
			}
			return items;
		}
		this.model.set('testItems', rnd());
	}

}