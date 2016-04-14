COLOR = Utils.randomColor()
ACCELERATION = 80

background = new BackgroundLayer backgroundColor: COLOR, opacity: 0.08


box = new Layer
	height: 140
	width: 140
	borderRadius: 4
	backgroundColor: COLOR, opacity: 0.8

box.center()

BOX_ORIGINAL = box.props
	
box.draggable.enabled = true

box.on Events.DragStart, (event) ->
	@originX = event.offsetX / @width
	@originY = event.offsetY / @height
	
	@animate 
		properties: 
			scale: 1.2
			brightness: 80
		curve: "spring(200, 14, 10, 0)"

box.on Events.DragMove, ->
	@animate
		properties:
			rotationX: - Utils.modulate @draggable.calculateVelocity().y, [-1, 1], [-45, 45], true
			rotationY: Utils.modulate @draggable.calculateVelocity().x, [-1, 1], [-45, 45], true
		curve: "spring(200, 18, 10, 0.1)"

box.on Events.DragEnd, ->
	@animateStop

	@animate
		properties:
			rotationX: BOX_ORIGINAL.rotationX
			rotationY: BOX_ORIGINAL.rotationY
			rotationZ: BOX_ORIGINAL.rotationZ
			scale: BOX_ORIGINAL.scale
			brightness: BOX_ORIGINAL.brightness
		curve: "spring(200, 30, 0, 0, 0.1)"