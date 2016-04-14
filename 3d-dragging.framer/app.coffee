COLOR = Utils.randomColor(0.5)

Screen.perspective = 800
Screen.backgroundColor = COLOR.lighten(40)

box = new Layer
	x: Align.center, y: Align.center
	size: 140
	borderRadius: 4
	backgroundColor: COLOR 
	opacity: 0.8

box.orgProps = box.props
	
box.draggable.enabled = true
box.draggable.constraints = Screen.frame

# Events

box.on Events.TapStart, (event) ->
	this.originX = event.offsetX / this.width
	this.originY = event.offsetY / this.height
	
	this.animate 
		properties: 
			scale: 1.2
			brightness: 80
		curve: "spring(200, 14, 10, 0, 0.2)"

box.on Events.DragMove, ->
	this.animate
		properties:
			rotationX: - Utils.modulate(this.draggable.calculateVelocity().y, [-1, 1], [-45, 45], true)
			rotationY: Utils.modulate(this.draggable.calculateVelocity().x, [-1, 1], [-45, 45], true)
		curve: "spring(200, 18, 10, 0.1)"

box.on Events.TapEnd, ->
	this.animateStop

	this.animate
		properties:
			rotationX: box.orgProps.rotationX
			rotationY: box.orgProps.rotationY
			rotationZ: box.orgProps.rotationZ
			scale: box.orgProps.scale
		curve: "spring(200, 30, 0, 0, 0.1)"