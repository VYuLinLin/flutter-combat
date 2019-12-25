import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation}) : super(key: key, listenable: animation);
   
   Widget build(BuildContext context) {
     final Animation<double> animation = listenable;
     return Center(
       child: Image.asset('images/kefu.png',
        width: animation.value,
        height: animation.value,),
     );
   }
}
class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimationRoute> with TickerProviderStateMixin  {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this
    );
    // 使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // 图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    //..addListener(() {
    //   setState(() {});
    // });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // 动画恢复到初始状态
        controller.forward();
      }
    });
    // 启动动画（正向执行）
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      // body: Center(
      //   child: Image.asset('images/kefu.png',
      //     width: animation.value,
      //     height: animation.value,
      //   ),
      // ),
      // body: AnimatedImage(animation: animation),
      body: Column(
        children: <Widget>[
          AnimatedBuilder(
            animation: animation,
            child: Image.asset('images/kefu.png'),
            builder: (BuildContext ctx, Widget child) {
              return Center(
                child: Container(
                  height: animation.value,
                  width: animation.value,
                  child: child,
                ),
              );
            },
          ),
          HeroAnimationRoute(), // Hero动画
          RaisedButton(
            child: Text('交织动画'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => StaggerRoute()
              ));
            },
          ) // 交织动画
        ],
      ),
    );
  }

  dispose() {
    // 路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

// Hero 动画
class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: InkWell(
        child: Hero(
          tag: 'avatar', // 唯一标记，前后两个路由页的hero的tag必须相同
          child: ClipOval(
            child: Image.asset('images/kefu.png', width: 50,),
          ),
        ),
        onTap: () {
          Navigator.push(context, PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: Scaffold(
                  appBar: AppBar(title: Text('原图'),), 
                  body: HeroAnimationRouteB(),
                )
              );
            }
          ));
        },
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'avatar', // 唯一标记，前后两个路由页的hero的tag必须相同
        child: Image.asset('images/kefu.png'),
      ),
    );
  }
}

// 交织动画（Stagger Animation）
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    // 高度动画
    height = Tween<double>(
      begin: .0,
      end: 300.0
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.6, // 间隔，前60%的动画时间
          curve: Curves.ease
        )
      )
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.6, // 间隔，前60%的动画时间
          curve: Curves.ease
        )
      )
    );

    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: .0),
      end: EdgeInsets.only(left: 100.0)
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6, 1.0, // 间隔，后40%的动画时间
          curve: Curves.ease
        )
      )
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class StaggerRoute extends StatefulWidget {
  @override
  _StaggerRouteState createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this
    );
  }


  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('交织动画'),),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color:  Colors.black.withOpacity(0.5),
              ),
            ),
            //调用我们定义的交织动画Widget
            child: StaggerAnimation(
                controller: _controller
            ),
          ),
        ),
      ),
    );
  }
}