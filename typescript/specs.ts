module Demo.Specs {
	import MyControls = Backbone.Components.Controls;
	import Behaviours = Backbone.Components.Behaviours;
	export var specifySimple = function() {
		describe("A suite", function() {
			it("is it hansi?", function() {
				var name = 'Hansi'
				var view:Backbone.View = window['demoSimple'];
				view.$('input').val(name).change();
				expect(view.$('span').text()).toBe(name);
			});
		});
	}
	export var specifySimpleHTML = function() {
		describe("A suite", function() {
			var name = '<b>Hansi</b>'
			it("is it " + name + "?", function() {
				var view:Backbone.View = window['demoSimpleHTML'];
				view.model.set('name', name);
				expect(view.$('span').html()).toBe(name);
			});
		});
	}

	export var specifyMyComps = function() {
		describe("An empty suite", function() {

		});
	}
	export var specifySelect = function() {
		describe("model driven selects", function() {
			var view:SelectView = window['demoSelect'];
			var options = [
				{
					value: "aaa",
					label: "select aaaa"
				},
				{
					value: "b",
					label: "select b"
				}
			];
			var otherOptions = _.clone(options);
			otherOptions.push({
				value: "c",
				label: "select c"
			});
			var lastOptions = [
				{
					value: "x",
					label: "everything"
				},
				{
					value: "y",
					label: "changed"
				}
			];
			it("options from a model", function() {
				view.model.set('options', options);
				expect(view.$('select option').length).toBe(2);
			});
			it("select option", function() {
				view.model.set('test', 'b');
				expect(view.$('select').val()).toBe('b');
			});
			it("other options from a model", function() {
				view.model.set('options', otherOptions);
				expect(view.$('select option').length).toBe(3);
			});
			it("selected remained the same", function() {
				expect(view.$('select').val()).toBe('b');
			});

			it("change everything and reset value", function() {
				view.model.set('options', lastOptions);
				expect(view.$('select').val()).toBe('x');
			});

			it("fires on user interaction", function() {
				view.$('select').val('y').change();
				expect(view.$('select').val()).toBe('y');
				expect(view.model.get('test')).toBe('y');
			});
		});
	}
	export var specifyFeedback = function() {
		describe("Feedback in your components", function() {
			var view:Backbone.View = window['demoFeedback'];
			it("without a template", function() {
				var zip = '1234';
				view.$('input[name=zip]').val(zip).change();
				expect(view.model.get('zip')).toBe(zip);
				expect(view.$('div.controlWithFeedback div.feedback').children().length).toBe(2);
			});
			it("with a template", function()  {
				var name = 'Hansi';
				view.$('input[name=name]').val(name).change();
				var listEl = view.$('div.controlWithFeedback ol.feedback');
				expect(view.model.get('name')).toBe(name);
				expect(listEl.children().length).toBe(2);
				expect($(listEl.children()[0]).find('pre.feedback-text').text()).toBe('awesome');
				expect($(listEl.children()[1]).find('pre.feedback-text').text()).toBe('ok');
			});
			it('attaches the feedback class to the controls top level element', function() {
				view.$('input[name=name]').val('').change();
				expect(view.$('#inputName').hasClass(Behaviours.Feedback.LEVEL_ERROR)).toBe(true);
			});
		});
	};
	export var specifyList = function() {

	};
}