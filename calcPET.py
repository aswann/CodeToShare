def calcPET(SH,LH,T,RH,U,ps): 

    #---- Calculate PET
    #
    # function PET = calcPET(SH,LH,T,RH,Umag,ps)
    #
    # PET = 1/Lv(DELTA*(SH+LH)+rhoa*cp*estar(T)*(1-RH)*CH*Umag)/(DELTA + gamma*(1+rs*CH*Umag))
    #
    # where 
    # T is in Kelvin    - Surface temperature
    # LH, SH in W/m2    - Latent Heat Flux, Sensible Heat Flux
    # RH in percent     - Relative Humidity
    # Umag in m/s       - Magnitude of Wind
    # and ps in Pascals - surface pressure
    #
    #
    #
    # SH = Sensible Heat
    # LH = Latent Heat
    # Lv = Latent Heat of vaporization
    # DELTA = slope of Clausius Clayperyon at T
    # rhoa = density of air, calculated as 1.01*PV/RT
    # R = ideal gas constant
    # cp = heat capacity of air (J/g/K)
    # estar(T) = saturated VP at T from CC
    # RH = relative humidity at 2M in percent
    # CH = drag coeff
    # Umag = wind speed magnitude
    # gamma = cp*ps/epsilon*Lv
    # epsilon = 0.622 (from Scheff 2013)
    # rs = stomatal resistance, 30 s/m day, 200 s/m night.
    # rs*CH in Cook paper is 0.34, which back calculates rs to 40
    #
    # drag coeff has a bunch of other constants
    # CH = k^2/(ln[(zw-d)/zom]*ln[zh-d/zoh])
    # k = von Karman constant, 0.41
    # h = standard veg height, 0.5m for alfalfa
    # zom = momentum roughness length, 0.123*h
    # zoh = scalar roughness length, 0.0123*h
    # zh = height of temperature and humidity measurements, 2 meters
    # zw = height of wind measurements, 2 meters
    # d = zero plane adjustment, 0.08 meters or 0 m


    #------- Set constants
    Lv = 2.45e6 # J/kg
    rs =  40 #s/m #matches Cook et al 2014
    epsilon = 0.622 #unitless
    cp = 4182 #J/kg/K
    R = 289.6 # J/kg/K
    Rv=461 # J/kg/K

    # drag constant coeff
    k= 0.41 #unitless
    h=0.5 #m
    zom = 0.123*h #m
    zoh =0.0123*h #m
    zh = 2 #m
    zw = 2 #m
    d = 0.08 #m

    rhoa = (1.01)*ps/Rv/(T)  #kg/m3 , T in Kelvin
    gamma = ps*cp/epsilon/Lv #Pa/K or Pa/C
    CH = k^2/(np.log((zw-d)/zom)*np.log((zh-d)/zoh)) #unitless

    estarT = 610.8*exp(Lv/Rv*(1/273.15 - 1/(T)))  #T in Kelvin, final unit Pa
    DELTA = Lv*estarT/Rv/((T)*(T)) #Pa/K, T should be in Kelvin

    mmH2OperPa = 9.80665 # mmH2O/Pa
    sperday=60*60*24

    # The full way
    PET = sperday*(1/Lv)*(DELTA*(SH+LH)+rhoa*cp*estarT*(1-RH)*CH*Umag)/(DELTA + gamma*(1+rs*CH*Umag))

    # The approximated way for PS1
    #PET_PS1 = (0.0352*DELTA*(SH+LH)+gamma*(900/T)*Umag*estarT*(1-RH))/(DELTA +gamma*(1+0.34*Umag))

    return PET
