//
//  ProfileVC+DataApi.swift
//  Gifts
//
//  Created by Apple on 02/06/22.
//

import Foundation
import SDWebImage
import Charts // You need this line to be able to use Charts Library

extension ProfileAddVC{
  
    func gerGraph() {
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.getGraph(param: param, isAuthorization: true) { [self] (data) in
            arrGraph = data.data ?? []
            let monthInt = Calendar.current.component(.month, from: Date())
            units.removeAll()
            month.removeAll()
            for i in 0..<monthInt {
                units.append(Double(arrGraph[i].total ?? 0))
                month.append(months[i])
            }
            setChart(dataPoints: month, values: units)
        }
    }
    
    func getProfile(){
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.userGetProfile(param: param, isAuthorization: true) { [self] (data) in
            print("profileprofile",data)
            ProfileData =  data.data?.gift_details ?? [Giftdetails]()
            if ProfileData.count ==  0 {
                imgCollView.isHidden = true
                btnViewAll.setTitle("Add New Gift", for: .normal)
            }else{
                imgCollView.isHidden = false
            }
            gerGraph()
            userImg.sd_imageIndicator = SDWebImageActivityIndicator.white
            let carImg = data.data?.image
            userImg.sd_setImage(with: URL(string: carImg!), placeholderImage: UIImage(named: ""))
            receiverImg.sd_imageIndicator = SDWebImageActivityIndicator.white
            let carImg1 = data.data?.image
            receiverImg.sd_setImage(with: URL(string: carImg1!), placeholderImage: UIImage(named: ""))
            LblMonthGifts.text = String(data.data?.gift_mothly ?? 0)
            LbltotalGift.text = String(data.data?.gift_count ?? 0)
            LbluserName.text = "\(data.data?.first_name ?? "") \(data.data?.last_name ?? "")"
            LblReceiverName.text = "\(data.data?.first_name ?? "") \(data.data?.last_name ?? "")"
           
            if data.data?.user_address?.count == 0 {
                
            }else{
            }
            LblDescription.text = data.data?.description
            LblReceiverDesp.text = data.data?.description
            
            if UserStoreSingleton.shared.userType == "giver" {
                stateSwitch.isOn = false
               
                stateSwitch.tintColor = offColor
                giverView.isHidden = false
                receiverView.isHidden = true
            }else{
                stateSwitch.onTintColor = onColor
                stateSwitch.isOn = true
                giverView.isHidden = true
                receiverView.isHidden = false
            }
        }
    }
    func driverUpdateStatus(){
       
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["user_type":userStatus ?? ""]
        
        OnboardViewModel.shared.updateDriverStatus(param: param, isAuthorization: true) { [self] (data) in
          
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UserStoreSingleton.shared.userType = data.data?.user_type
                if self.stateSwitch.isOn {
                    self.userStatus = "receiver"
                    self.giverView.isHidden = true
                    self.receiverView.isHidden = false
                } else {
                    self.giverView.isHidden = false
                    self.userStatus = "giver"
                    self.receiverView.isHidden = true
                }
 
            }
        }
    }
    func setChart(dataPoints: [String], values: [Double]) {
        dataEntries.removeAll()
        for i in 0 ..< dataPoints.count {
            dataEntries.append(ChartDataEntry(x: Double(i), y: values[i]))
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        lineChartDataSet.axisDependency = .left
        lineChartDataSet.setColor(BaseViewController.appColor)
        lineChartDataSet.setCircleColor(BaseViewController.appColor)
        lineChartDataSet.lineWidth = 3.0
        lineChartDataSet.circleRadius = 5.0
        lineChartDataSet.fillAlpha = 2
        lineChartDataSet.fillColor = BaseViewController.appColor
        lineChartDataSet.highlightColor = UIColor.white
        lineChartDataSet.drawCircleHoleEnabled = true
        
        var dataSets = [LineChartDataSet]()
        dataSets.append(lineChartDataSet)

        let lineChartData = LineChartData(dataSets: dataSets)
        chtChart.data = lineChartData
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        chtChart.data?.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        chtChart.rightAxis.enabled = false
        chtChart.xAxis.drawGridLinesEnabled = true
        chtChart.leftAxis.axisMinimum = 1
        chtChart.xAxis.labelPosition = .bottom
        chtChart.animate(xAxisDuration: 1)
        chtChart.leftAxis.drawGridLinesEnabled = false
        chtChart.leftAxis.granularityEnabled = true
        chtChart.leftAxis.granularity = 1.0
        chtChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        chtChart.xAxis.setLabelCount(dataPoints.count, force: true)
        chtChart.legend.enabled = true
     }

}
