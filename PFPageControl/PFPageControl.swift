//
//  PFPageControl.swift
//  PFPageControl
//
//  Created by Ivan Ferencak on 19.03.2021..
//

import UIKit

public final class PFPageControl: UIView {
    
    //MARK: - Public vars
    
    /// The tint color for non-selected indicators. Default is white with 0.45 alpha.
    public var pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.45) { didSet { updateColors() } }
    
    /// The tint color for the currently-selected indicator. Default is white.
    public var currentPageIndicatorTintColor = UIColor.white { didSet { updateColors() } }
    
    /// Padding on left and right side of dot views. Default is 15.
    public var edgePadding: CGFloat = 15 { didSet { updateBackgroundFrame() } }
    
    /// Scale for currently-selected indicator. Default is 1.
    public var selectedIndicatorScale: CGFloat = 1 { didSet { updateScale() } }
    
    /// Enables/disables gestures. Default is true.
    public var gestureEventsEnabled: Bool = true
    
    /// Enables/disables continues interacton. Default is true.
    public var allowsContinuousInteraction: Bool = true
    
    /// The background color of the background view. Default is systemBackground with 0.5 alpha.
    public var backgroundViewColor: UIColor = UIColor.white.withAlphaComponent(0.5) {
        didSet {
            backgroundView.backgroundColor = backgroundViewColor
        }
    }
    
    /// The preferred background style. Default is .automatic.
    public var backgroundStyle: PFPageControl.BackgroundStyle = .automatic {
        didSet {
            backgroundView.alpha = backgroundStyle == .prominent ? 1 : 0
        }
    }
    
    /// Hides the indicator if there is only one page. Default is false.
    public var hidesForSinglePage: Bool = false {
        didSet {
            hideForSingleIfNeeded()
        }
    }
    
    /// The preferred image for indicators. Symbol images are recommended. Default is nil.
    public var preferredIndicatorImage: UIImage? {
        didSet {
            addDotViews()
        }
    }
    
    
    /// Number of pages. Default is 0.
    public var numberOfPages: Int = 0 {
        didSet {
            guard numberOfPages != oldValue else { return }
            numberOfPages = max(0, numberOfPages)
            invalidateIntrinsicContentSize()
            addDotViews()
            
            hideForSingleIfNeeded()
            
            if oldValue != 0 && oldValue < numberOfPages && numberOfPages > pagesFit {
                if oldValue - 1 - currentPage == 0 {
                    numDotsOffset += 2
                } else if oldValue - 1 - currentPage == 1 {
                    numDotsOffset += 1
                }
            } else if oldValue != 0 && oldValue > numberOfPages {
                if numberOfPages - currentPage <= 1 {
                    currentPage -= 1
                    numDotsOffset -= 1
                }
            }
            
            calculatePagesFit()
            updatePositions()
        }
    }
    
    /// Current page. Default is 0. Value is pinned to 0..numberOfPages-1.
    public var currentPage: Int = 0 {
        didSet {
            guard currentPage != oldValue else { return }
            
            currentPage = max(0, min (numberOfPages - 1, currentPage))
            
            updateColors()
            setOffsetByDots()
        }
    }
    
    /// Spacing between dots. Default is 10.
    public var spacing: CGFloat = 10 {
        didSet {
            guard spacing != oldValue else { return }
            
            spacing = max(1, spacing)
            
            calculatePagesFit()
            updatePositions()
            
        }
    }
    
    /// Regulates dots dimensions. Default is 8.
    public var diameter: CGFloat = 8 {
        didSet {
            guard diameter != oldValue else { return }
            
            diameter = max(1, diameter)
            dotViews.forEach {
                $0.transform = CGAffineTransform.identity
                $0.frame = CGRect(origin: .zero, size: CGSize(width: diameter, height: diameter))
            }
            
            calculatePagesFit()
            updatePositions()
        }
    }
    
    
    //MARK: - Private vars
    
    private var backgroundView: BackgroundView!
    private var initialOffset: Int = 0
    private var lastTickTimer: Timer?
    private var lastTouchPointX: CGFloat = 0
    private var lastDirection: Direction = .right
    private var lastSize = CGSize.zero
    private var pageIndicatorTintColors: [Int: UIColor] = [Int: UIColor]()
    private var currentPageIndicatorTintColors: [Int: UIColor] = [Int: UIColor]()
    private var indicatorImages: [Int: UIImage?] = [Int: UIImage]()
    
    private var dotViews: [PageItem] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            dotViews.forEach(addSubview)
            updateColors()
            updatePositions()
        }
    }
    
    private var pagesFit: Int = 0 {
        didSet {
            updateBackgroundFrame()
        }
    }
    
    private var numDotsOffset: Int = 0 {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: self.updatePositions, completion: nil)
            }
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        calculatePagesFit()
        let pages = min(pagesFit, numberOfPages)
        let width = CGFloat(pages) * diameter + CGFloat(pages - 1) * spacing
        return CGSize(width: width + edgePadding*2, height: 40)
    }
    
    //MARK: - init
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        isOpaque = false
        backgroundView = BackgroundView(frame: .zero)
        addSubview(backgroundView)

        backgroundStyle = .automatic
        
        setupGestureRecognizers()
    }
    
    //MARK: - Public funcs
    
    /// currentPage += 1
    public func nextPage() {
        currentPage += 1
        lastDirection = .right
    }
    
    /// currentPage -= 1
    public func prevPage() {
        currentPage -= 1
        lastDirection = .left
    }
    
    /// Sets tintColor for specific index.
    public func setTintColor(color: UIColor, forPage index: Int) {
        pageIndicatorTintColors[index] = color
        updateColors()
    }
    
    /// Sets tintColor for specific index when that page is current.
    public func setCurrentPageTintColor(color: UIColor, forPage index: Int) {
        currentPageIndicatorTintColors[index] = color
        updateColors()
    }
    
    /// Returns the minimum size required to display indicators for the given page count.
    public func size(forNumberOfPages pageCount: Int) -> CGSize {
        let edge = edgePadding * 2
        let diameters = diameter * CGFloat(numberOfPages)
        let spacings = spacing * CGFloat(numberOfPages - 1)
        return CGSize(width: edge + diameters + spacings, height: bounds.height)
    }
    
    /**
     * @abstract Override the indicator image for a specific page.
     * @param image    The image for the indicator. Resets to the default if image is nil.
     * @param page      Must be in the range of 0..numberOfPages
     */
    public func setIndicatorImage(_ image: UIImage?, forPage page: Int) {
        indicatorImages[page] = image
        addDotViews()
    }
    
    //MARK: - Private funcs
    
    private func setupGestureRecognizers() {
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(self.didTouch(gesture:)))
        addGestureRecognizer(tapEvent)
        
        let longTouch = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        longTouch.minimumPressDuration = 0.2
        addGestureRecognizer(longTouch)
    }
    
    @objc private func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if !gestureEventsEnabled || !allowsContinuousInteraction { return }
        
        if gesture.state == .changed {
            let touchX = gesture.location(in: self).x
            let comparePoint = dotViews[currentPage].frame.origin.x + diameter/2
            
            if touchX < edgePadding + spacing*2 + diameter*2 && pagesFit < numberOfPages && currentPage > 2 {
                let translation = (touchX - (edgePadding + spacing*2 + diameter*2))/8
                transform = CGAffineTransform.identity.translatedBy(x: translation, y: 0).scaledBy(x: 1.05, y: 1.0)
                
                if lastTickTimer == nil {
                    lastTickTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { _ in
                        self.prevPage()
                    })
                }
                return
            }
            
            if touchX > edgePadding + diameter*CGFloat(pagesFit-2) + spacing*CGFloat(pagesFit - 3) && pagesFit < numberOfPages && currentPage < numberOfPages - 4 {
                let translation = (touchX - (edgePadding + diameter*CGFloat(pagesFit-2) + spacing*CGFloat(pagesFit - 3)))/8
                transform = CGAffineTransform.identity.translatedBy(x: translation, y: 0).scaledBy(x: 1.05, y: 1.0)
                
                if lastTickTimer == nil {
                    lastTickTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { _ in
                        self.nextPage()
                    })
                }
                return
            }
            
            removeTimer()
            
            if fabsf(Float(touchX - comparePoint)) < Float((diameter)/2) { return }

            touchX < comparePoint ? prevPage() : nextPage()
            
        } else if gesture.state == .began {
            UIView.animate(withDuration: 0.1) {
                if self.backgroundStyle == .automatic {
                    self.backgroundView.alpha = 1
                }
                self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.1) {
                if self.backgroundStyle == .automatic {
                    self.backgroundView.alpha = 0
                }
                self.transform = CGAffineTransform.identity
            }
            removeTimer()
        }
    }
    
    @objc private func didTouch(gesture: UITapGestureRecognizer) {
        if !gestureEventsEnabled { return }
        
        let touchX = gesture.location(in: self).x
        
        if touchX == lastTouchPointX {
            lastDirection == .left ? prevPage() : nextPage()
            return
        }
        
        let comparePoint = dotViews[currentPage].frame.origin.x + diameter/2
        
        if fabsf(Float(touchX - comparePoint)) < Float((diameter)/2) { return }
        
        touchX < comparePoint ? prevPage() : nextPage()
        lastTouchPointX = touchX
    }
    
    private func removeTimer() {
        lastTickTimer?.invalidate()
        lastTickTimer = nil
    }
    
    private func addDotViews() {
        dotViews = (0..<numberOfPages).map { page in
            
            if indicatorImages[page] != nil {
                return ImageView(diameter: diameter, image: indicatorImages[page]!)
            }
            
            return preferredIndicatorImage != nil ? ImageView(diameter: diameter, image: preferredIndicatorImage) : DotView(diameter: diameter)
        }
    }
    
    private func hideForSingleIfNeeded() {
        isHidden = hidesForSinglePage && numberOfPages <= 1 ? true : false
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.size != lastSize else { return }
        lastSize = bounds.size
        
        calculatePagesFit()
        initialOffset = max(0, currentPage - pagesFit + 3)
        updatePositions()
    }
    
    private func updateColors() {
        dotViews.enumerated().forEach { page, dot in
            if page == currentPage {
                dot.changeColor(color: currentPageIndicatorTintColors[page] != nil ? currentPageIndicatorTintColors[page]! : currentPageIndicatorTintColor)
            } else if let color = pageIndicatorTintColors[page] {
                dot.changeColor(color: color)
            } else {
                dot.changeColor(color: pageIndicatorTintColor, withAnimation: true)
            }
            
           
        }
    }
    
    private func setOffsetByDots() {
        if bounds == .zero { return }
        
        if currentPage - numDotsOffset > pagesFit - 3 && currentPage < numberOfPages - 2 {
            numDotsOffset += 1
        } else if currentPage - numDotsOffset < 2 && currentPage > 1 {
            numDotsOffset -= 1
        } else {
            updateScale()
        }
    }
    
    private func updatePositions() {
        if initialOffset != 0 {
            numDotsOffset = numberOfPages - currentPage <= 2 ? initialOffset - (3 - (numberOfPages - currentPage)) : initialOffset
            initialOffset = 0
        }
        
        let horizontalOffset = CGFloat(-numDotsOffset - initialOffset) * (diameter + spacing) + edgePadding + backgroundView.frame.origin.x
        dotViews.enumerated().forEach { page, dot in
            let center = CGPoint(x: horizontalOffset + bounds.minX + diameter / 2 + (diameter + spacing) * CGFloat(page), y: bounds.midY)
            dot.center = center
        }
        updateScale()
    }
    
    private func updateBackgroundFrame() {
        let pages = min(pagesFit, numberOfPages)
        let width = CGFloat(pages) * diameter + CGFloat(pages - 1) * spacing
        
        backgroundView.frame = CGRect(x: (bounds.width - width)/2 - edgePadding, y: (bounds.height-24)/2, width: width + edgePadding * 2, height: 24)
    }
    
    private func calculatePagesFit() {
        var fit = Int(floor((bounds.width - edgePadding*2)/(self.diameter + spacing) + 1))
        fit = max(fit, 5)
        pagesFit = bounds.width == 0 ? 8 : fit
    }
    
    private func updateScale() {
        dotViews.enumerated().forEach { page, dot in
            let scale: CGFloat = {
                if page == currentPage { return selectedIndicatorScale }
                if numDotsOffset > 0 {
                    if page < numDotsOffset { return 0 }
                    if page == numDotsOffset { return 0.5 }
                    if page == numDotsOffset + 1 { return 0.75 }
                }
                if numDotsOffset + pagesFit != numberOfPages {
                    if page > numDotsOffset + pagesFit - 1 { return 0 }
                    if page > numDotsOffset + pagesFit - 2 { return 0.5 }
                    if page > numDotsOffset + pagesFit - 3 { return 0.75 }
                }
                return 1
            }()
            dot.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
}

extension PFPageControl {
    public enum InteractionState : Int {

        /// The default interaction state, where no interaction has occured.
        case none = 0
        
        /// The interaction state for which the page was changed via a single, discrete interaction.
        case discrete = 1
        
        /// The interaction state for which the page was changed via a continuous interaction.
        case continuous = 2
    }


    public enum BackgroundStyle : Int {

        /// The default background style that adapts based on the current interaction state.
        case automatic = 0

        /// The background style that shows a full background regardless of the interaction
        case prominent = 1

        /// The background style that shows a minimal background regardless of the interaction
        case minimal = 2
    }
    
    private enum Direction: Int {
        case left = 0
        case right = 1
    }
}
