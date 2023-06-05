#! /bin/tcsh
# script to copy coupledPPE files from campaign storage

# -- my directory to copy files to
set myscratch = /glade/scratch/hugo

echo 'directory to copy files to' $myscratch


# Land output variables are here:
#/glade/campaign/cgd/tss/czarakas/CoupledPPE/coupled_simulations/COUP####_PI_SOM_v02/lnd/proc/tseries

# Atmosphere output variabiles are here:
#/glade/campaign/cgd/tss/czarakas/CoupledPPE/coupled_simulations/COUP####_PI_SOM_v02/atm/proc/tseries

set outputdir = /glade/campaign/cgd/tss/czarakas/CoupledPPE/coupled_simulations

echo 'directory containing output' $outputdir

# -- List of experiments (use only v02 folders, which have all years concatenated)
# COUP002 was removed and replaced with COUP0037 (0002 crashed)
set caselist = (COUP0000_PI_SOM COUP0001_PI_SOM_v02 COUP0003_PI_SOM_v02 COUP0004_PI_SOM_v02 COUP0005_PI_SOM_v02 COUP0006_PI_SOM_v02 COUP0007_PI_SOM_v02 COUP0008_PI_SOM_v02 COUP0009_PI_SOM_v02 COUP0010_PI_SOM_v02 COUP0011_PI_SOM_v02 COUP0012_PI_SOM_v02 COUP0013_PI_SOM_v02 COUP0014_PI_SOM_v02 COUP0015_PI_SOM_v02 COUP0016_PI_SOM_v02 COUP0017_PI_SOM_v02 COUP0018_PI_SOM_v02 COUP0019_PI_SOM_v02 COUP0020_PI_SOM_v02 COUP0021_PI_SOM_v02 COUP0022_PI_SOM_v02 COUP0023_PI_SOM_v02 COUP0024_PI_SOM_v02 COUP0025_PI_SOM_v02 COUP0026_PI_SOM_v02 COUP0027_PI_SOM_v02 COUP0028_PI_SOM_v02 COUP0029_PI_SOM_v02 COUP0030_PI_SOM_v02 COUP0031_PI_SOM_v02 COUP0032_PI_SOM_v02 COUP0033_PI_SOM_v02 COUP0034_PI_SOM_v02 COUP0035_PI_SOM_v02 COUP0036_PI_SOM_v02 COUP0037_PI_SOM_v02)

echo 'caselist set'

# -- Variables
# Here are the long names (can view full info including units in necdf headers)
# EFLX_LH_TOT   Total Latent Heat Flux
# FSH   Sensible Heat Flux
# FSDS  Flux Solar Downwelling at the Surface
# FSA   Flux Solar Absorbed
# FLDS  Flux Longwave Downwelling at the Surface
# TSKIN Skin Temperature 
# TSA   Surface Air Temperature
# RH2M  Surface Relative Humidity
# RAIN  Precipitation
# GPP   Gross Primary Production
# NPP   Net Primary Production
# GSSUNLN       Stomatal Conducatance of sun leaves at local noon
# GSSHALN       Stomatal Conducatance of shade leaves at local noon
# TLAI  Total projected Leaf Area
# FCTR  Transpiration (in energy units)
# FCEV  Canopy Evaporation (in energy units)
# FGEV  Ground Evaporation (in energy units)
# VPD_CAN       Canopy Vapor Pressure Deficit 
# BTRAN2        Soil Moisture Stress scalar


#set atm_vars = (FLNS) # skip this for now, but I couldn't find other longwave surface fluxes in the land output files

set lnd_vars = (EFLX_LH_TOT FSH FSDS FSA FLDS TSKIN TSA RH2M RAIN GPP NPP GSSUNLN GSSHALN TLAI FCTR FCEV FGEV VPD_CAN BTRAN2)

echo 'list of variables set'

foreach casename ($caselist)
        echo "casename =" $casename
        set workdir = /glade/campaign/cgd/tss/czarakas/CoupledPPE/coupled_simulations/$casename/lnd/proc/tseries
        echo $workdir
        set outputdir = $myscratch

        foreach var ($lnd_vars)
                echo 'copying ' $var
                cp $workdir/$casename.clm2.h0.timeseries.$var.nc $outputdir
                # echo 'I found ' $workdir/$casename.clm2.h0.timeseries.$var.nc $outputdir # for testing

        end # loop over variables
end # loop over cases

echo 'all done!'
