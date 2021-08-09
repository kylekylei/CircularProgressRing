//
//  ContentView.swift
//  CircularProgressRing
//
//  Created by Kyle Lei on 2021/8/5.
//

import SwiftUI
struct DrawView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
           
        let oneDegree = CGFloat.pi/180
        let lineWidth: CGFloat = 50
        let radius: CGFloat = 60
        var startDegree: CGFloat = 270
        let center = CGPoint(x: lineWidth + radius, y: lineWidth + radius)
        
        let percentage: CGFloat = 30
        
        let radiusOfDonut: CGFloat = 125
        let percentageOfDonut: [CGFloat] = [30, 30, 40]
        
        let radiusOfDash = radiusOfDonut
        let degreeOfGap: CGFloat = 6
 
        
        func shadowEffect(_ layer: CALayer) {
            layer.shadowOffset = .zero
            layer.shadowColor = UIColor.cyan.cgColor
            layer.shadowRadius = 16
            layer.shadowOpacity = 0.75
        }
    
        
        //circle
        let circlePath = UIBezierPath(ovalIn: CGRect(x: lineWidth, y: lineWidth, width: radius * 2, height: radius * 2))
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.cyan.cgColor
        circleLayer.opacity = 0.2
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        
                
        let percentagePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: oneDegree * startDegree, endAngle: oneDegree * ( startDegree + 360 * percentage / 100), clockwise: true)
               
        let percentageLayer = CAShapeLayer()
        percentageLayer.path = percentagePath.cgPath
        percentageLayer.strokeColor = UIColor.cyan.cgColor
        percentageLayer.lineWidth = lineWidth
        percentageLayer.fillColor = UIColor.clear.cgColor
        percentageLayer.lineCap = .butt
        
        

        shadowEffect(percentageLayer)
       
        
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 2 * (radius + lineWidth), height: 2 * (radius + lineWidth)))
        lable.textAlignment = .center
        
        let lableText = Int(percentage)
        lable.text = "\(lableText)%"
        lable.textColor = UIColor.cyan
        lable.font = UIFont(name: "AlienLeagueBold", size: 32)
    
        
        let circularView = UIView(frame: lable.frame)
        circularView.layer.addSublayer(circleLayer)
        circularView.layer.addSublayer(percentageLayer)
        circularView.addSubview(lable)
        circularView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 200)
        
        view.addSubview(circularView)
              
        //donut
        let donutView = UIView(frame: lable.frame)
        var opacityIndex: Float = 1
        
        for percentage in percentageOfDonut {
            let endDegree = startDegree + 360 * percentage / 100
            let percentageOfDonutPath = UIBezierPath(arcCenter: center, radius: radiusOfDonut, startAngle: oneDegree * startDegree, endAngle: oneDegree * endDegree, clockwise: true)
            let percentageOfDonutLayer = CAShapeLayer()
            percentageOfDonutLayer.path = percentageOfDonutPath.cgPath
            percentageOfDonutLayer.strokeColor = UIColor.cyan.cgColor
            percentageOfDonutLayer.lineWidth = lineWidth
            percentageOfDonutLayer.fillColor = UIColor.clear.cgColor
           
            
            percentageOfDonutLayer.opacity =  Float(1/opacityIndex)
            opacityIndex += 1
            
            shadowEffect(percentageOfDonutLayer)
        
            donutView.layer.addSublayer(percentageOfDonutLayer)
            
            func lableDonut(percentage: CGFloat, startDegree: CGFloat) -> UILabel {
                let textCenterDegree = startDegree + 360 * percentage / 100 / 2
                let textPath = UIBezierPath(arcCenter: center, radius: radiusOfDonut, startAngle: oneDegree * startDegree, endAngle: oneDegree * textCenterDegree, clockwise: true)
                
                let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
                lable.font = UIFont(name: "AlienLeagueBold", size: 32)
                lable.textColor = .black
                let lableText = Int(percentage)
                lable.text = "\(lableText)%"
                lable.sizeToFit()
                lable.center = textPath.currentPoint
                                
                return lable
            }
            
            donutView.addSubview(lableDonut(percentage: percentage, startDegree: startDegree))
            
            startDegree = endDegree
        }
        donutView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 200)
        view.addSubview(donutView)
              
        
        // Cookie
        let cookieView = UIView(frame: lable.frame)
        opacityIndex = 1
        for percentage in percentageOfDonut {
            let endDegree = startDegree + 360 * percentage / 100
            let radiusOfcookie = lineWidth / 2 + radius
            let cookiePath = UIBezierPath()
            cookiePath.move(to: center)
            cookiePath.addArc(withCenter: center, radius: radiusOfcookie, startAngle: oneDegree * startDegree, endAngle: oneDegree * endDegree, clockwise: true)
            
            
            let cookieLayer = CAShapeLayer()
            cookieLayer.path = cookiePath.cgPath
            cookieLayer.fillColor = UIColor.cyan.cgColor
            cookieLayer.opacity = 1 / opacityIndex
            opacityIndex += 1
            
            
            
            cookieView.layer.addSublayer(cookieLayer)
            
            func lableCookie(percentage: CGFloat, startDegree: CGFloat) -> UILabel {
            
                let textCenterDegree = startDegree + 360 * percentage / 100 / 2
                let textPath = UIBezierPath(arcCenter: center, radius: radiusOfcookie / 2 , startAngle: oneDegree * startDegree, endAngle: oneDegree * textCenterDegree, clockwise: true)
                
                let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
                lable.font = UIFont(name: "AlienLeagueBold", size: 32)
                lable.textColor = .black
                let lableText = Int(percentage)
                lable.text = "\(lableText)%"
                lable.sizeToFit() //!
                lable.center = textPath.currentPoint //!
                                
                return lable
            }
            
            
            cookieView.addSubview(lableCookie(percentage: percentage, startDegree: startDegree))
            startDegree = endDegree
            
        }
        
        cookieView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 550)
        view.addSubview(cookieView)
        
        
        
        //Dash
      
        func dsahRing(currentOfDash:Int, opacity: Float) -> UIView{
            
            let dashView = UIView(frame: lable.frame)
            let numOfDash = 12
            
            for _ in 1...currentOfDash {
                let numOfDash = CGFloat(numOfDash)
                let oneUnitdegree = (360 - degreeOfGap * numOfDash) / numOfDash
                let endDegree = startDegree + oneUnitdegree

                            
                let dashPath = UIBezierPath(arcCenter: center, radius: radiusOfDash, startAngle: oneDegree * startDegree, endAngle: oneDegree * endDegree, clockwise: true)
                let dashLayer = CAShapeLayer()
                dashLayer.path = dashPath.cgPath
                dashLayer.strokeColor = UIColor.cyan.cgColor
                dashLayer.lineWidth = lineWidth
                dashLayer.fillColor = UIColor.clear.cgColor
                shadowEffect(dashLayer)
                
                dashView.layer.addSublayer(dashLayer)
                dashView.layer.opacity = opacity
                startDegree = endDegree + degreeOfGap
                }
                       
            dashView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 550)
            return dashView
        }
               
        view.addSubview(dsahRing(currentOfDash: 12, opacity: 0.3))
        view.addSubview(dsahRing(currentOfDash: 10, opacity: 1))
        
        
    
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
}
struct ContentView: View {
    var body: some View {
        DrawView()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
