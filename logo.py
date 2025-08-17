import matplotlib.pyplot as plt
import matplotlib.patches as patches
import numpy as np
from matplotlib.colors import LinearSegmentedColormap
import os

def generate_lousybot_logo():
    """Generate a centered logo with padding for auto-cropping"""
    
    # Create figure
    fig, ax = plt.subplots(1, 1, figsize=(10, 10), dpi=300)
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 10)
    ax.axis('off')
    
    # Create smooth black to blue gradient background with centered pattern
    x = np.linspace(0, 10, 400)
    y = np.linspace(0, 10, 400)
    X, Y = np.meshgrid(x, y)
    
    # Create centered gradient pattern (like the original but smoother)
    Z = np.sin(X * 0.3) * np.cos(Y * 0.3) * 0.5 + 0.5
    
    # Define smooth color transition
    colors = ['#000000', '#1e1b4b', '#312e81', '#4338ca', '#6366f1']
    n_bins = 256  # More bins for smoother gradient
    cmap = LinearSegmentedColormap.from_list('lousybot', colors, N=n_bins)
    
    # Use imshow for smoother gradient
    ax.imshow(Z, extent=[0, 10, 0, 10], cmap=cmap, alpha=1.0, origin='lower')
    
    # More visible neural network-like background pattern
    for i in range(25):
        x_start = np.random.uniform(0, 10)
        y_start = np.random.uniform(0, 10)
        x_end = np.random.uniform(0, 10)
        y_end = np.random.uniform(0, 10)
        
        ax.plot([x_start, x_end], [y_start, y_end],
               color='#60a5fa', alpha=0.4, linewidth=1)
        
        # Add more visible nodes
        ax.plot(x_start, y_start, 'o', color='#3b82f6',
               markersize=3, alpha=0.6)
        ax.plot(x_end, y_end, 'o', color='#3b82f6',
               markersize=3, alpha=0.6)
    
    # Centered L icon (thicker and more prominent)
    l_x = [4, 4, 6]
    l_y = [7, 3, 3]
    
    # Create thick L with gradient
    for i in range(len(l_x)-1):
        ax.plot([l_x[i], l_x[i+1]], [l_y[i], l_y[i+1]], 
               color='#ffffff', linewidth=16, solid_capstyle='round')
    
    # Add glow effect to L
    for i in range(3):
        glow_alpha = 0.25 - i * 0.08
        glow_width = 16 + i * 4
        ax.plot([l_x[0], l_x[0]], [l_y[0], l_y[1]], 
               color='#60a5fa', linewidth=glow_width, 
               solid_capstyle='round', alpha=glow_alpha)
        ax.plot([l_x[0], l_x[1]], [l_y[1], l_y[1]], 
               color='#60a5fa', linewidth=glow_width, 
               solid_capstyle='round', alpha=glow_alpha)
    
    # Centered "LousyBot" text
    ax.text(5, 1.8, 'LousyBot', 
           fontsize=14, 
           fontweight='bold', 
           ha='center', 
           va='center', 
           color='#ffffff',
           alpha=0.9)
    
    plt.tight_layout()
    plt.savefig('logo.png',
                transparent=False,
                dpi=300,
                bbox_inches='tight',
                pad_inches=0,  # No padding - fill entire canvas
                facecolor='black')
    plt.close()
    
    print("✅ Logo generated successfully as 'logo.png'")

if __name__ == "__main__":
    print("🎨 Generating centered LousyBot logo...")
    generate_lousybot_logo()
    print("\n🎉 Logo created!")
    print("📁 File created:")
    print("   - logo.png (centered logo with padding for auto-crop)")